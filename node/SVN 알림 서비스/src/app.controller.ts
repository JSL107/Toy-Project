import { Controller, Get, Post } from '@nestjs/common';
import { AppService } from './app.service';

@Controller('file-watch')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Post()
  async watchSvnServer() {
    return await this.appService.watchSvnServer();
  }
}
