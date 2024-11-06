import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  async watchSvnServer() {
    return 'Hello World!';
  }
}
