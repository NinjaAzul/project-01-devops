import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { HealthController } from './health/health.controller';

@Module({
  imports: [],
  controllers: [AppController, HealthController],
  providers: [],
})
export class AppModule {}
