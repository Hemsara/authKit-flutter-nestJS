import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  appInfo() {
    return {"status" : "ok","message" : "Welcome to AuthKit API"};
  }
}
