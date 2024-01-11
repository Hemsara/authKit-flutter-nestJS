import { Global, Injectable } from '@nestjs/common';

@Global()
@Injectable()
export class ResponseHelperService {
  returnError(message: string) {
    return  {
      error: true,
      message: message,
    };
  }
  returnSuccess(data : Record<string, any>) {
    return {
        success: true,
         data,
    };
  }
}
