import {ForbiddenException, Injectable, NotFoundException, Res, UnauthorizedException} from '@nestjs/common';
import { LoginDTO } from './dto/login.dto';
import { RegisterDTO } from './dto/register.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { ResponseHelperService } from 'src/response-helper/response-helper.service';
import * as argon2 from 'argon2';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private responseHelperService: ResponseHelperService,
    private jwtService: JwtService,
  ) {}

  async loginUser(dto: LoginDTO) {
    const userExist = await this.prisma.user.findFirst({
      where: {
        email: dto.email,
      },
    });
    if (!userExist) {
      throw new NotFoundException('User under this email is  not found');
    }
    const passwordMatch = await argon2.verify(userExist.password, dto.password);
    if (!passwordMatch) {
      throw new UnauthorizedException('Password is incorrect');
    }
    const payload = { sub: userExist.id, username: userExist.email };
    return {
      access_token: await this.jwtService.signAsync(payload),
    };
  }
  async registerUser(dto: RegisterDTO) {
    const userExist = await this.prisma.user.findFirst({
      where: {
        email: dto.email,
      },
    });
    if (userExist) {
      throw new ForbiddenException(
        'User under this email is already registered',
      );
    }


    const hash = await argon2.hash(dto.password);

    const created = await this.prisma.user.create({
      data: {
        first_name: dto.firstName,
        last_name: dto.lastName,
        email: dto.email,
        password: hash,
      },
    });


    return  this.responseHelperService.returnSuccess(created);
  }
}
