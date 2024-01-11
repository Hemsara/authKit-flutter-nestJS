import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { AuthModule } from './auth/auth.module';
import { ResponseHelperService } from './response-helper/response-helper.service';
import {ConfigModule} from "@nestjs/config";

@Module({
  imports: [PrismaModule, AuthModule, ConfigModule.forRoot()],
  controllers: [AppController],
  providers: [AppService, ResponseHelperService],
})
export class AppModule {}
