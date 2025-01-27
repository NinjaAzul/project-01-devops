import { Controller, Get } from '@nestjs/common';

@Controller()
export class AppController {
  @Get()
  getHello(): string {
    return 'Hello World from DevOps!';
  }

  @Get('/K8s')
  getK8s(): string {
    console.log('ENV', process.env.DATABASE_URL);
    console.log('SECRET', process.env.API_KEY);
    return 'K8s is running! 🚀 MORE MORE MOREEEEEEEEEEEEEEEEEE';
  }
}
