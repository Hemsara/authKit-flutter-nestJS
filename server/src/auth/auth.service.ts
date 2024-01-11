import {
  ForbiddenException,
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
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

  // Login user
  async loginUser(dto: LoginDTO) {
    // * Check if a user exist with the given email
    const userExist = await this.prisma.user.findUnique({
      where: {
        email: dto.email,
      },
    });

    // * If user not found, throw NotFoundException
    if (!userExist) {
      throw new NotFoundException('User under this email is not found');
    }

    // * Decode and verify password
    const passwordMatch = await argon2.verify(userExist.password, dto.password);

    // * If password doesn't match, throw UnauthorizedException
    if (!passwordMatch) {
      throw new UnauthorizedException('Password is incorrect');
    }

    //* Generate JWT token
    const payload = { sub: userExist.id, username: userExist.email };
    return {
      access_token: await this.jwtService.signAsync(payload),
    };
  }

  // Register a new user
  async registerUser(dto: RegisterDTO) {
    // * Check if a user with the given email already exists
    const userExist = await this.prisma.user.findUnique({
      where: {
        email: dto.email,
      },
    });

    if (userExist) {
      throw new ForbiddenException(
        'User under this email is already registered',
      );
    }

    // * Hash the user's password using argon
    const hash = await argon2.hash(dto.password);

    // * Create a new user with the provided data
    const created = await this.prisma.user.create({
      data: {
        first_name: dto.firstName,
        last_name: dto.lastName,
        email: dto.email,
        password: hash,
      },
    });

    return this.responseHelperService.returnSuccess(created);
  }
}
