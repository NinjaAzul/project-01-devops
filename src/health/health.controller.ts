import { Controller, Get } from '@nestjs/common';

@Controller('')
export class HealthController {
  @Get('/healthz')
  getHealth(): string {
    return 'OK';
  }

  @Get('/readyz')
  getReady(): string {
    console.log('Ready check');
    return 'OK';
  }
}
