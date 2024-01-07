import { Injectable } from '@nestjs/common';
import { LoginDTO } from './dto/login.dto';
import { RegisterDTO } from './dto/register.dto';


@Injectable()
export class AuthService {
  loginUser(dto: LoginDTO) {
    return 'This action adds a new auth';
  }
  registerUser(dto: RegisterDTO) {
    return 'This action adds a new auth';
  }
  
}
