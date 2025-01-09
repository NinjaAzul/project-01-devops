import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma.service';

@Injectable()
export class AppService {
  constructor(private prisma: PrismaService) {}

  async getHello() {
    // Usando a instância do PrismaService injetada
    return await this.prisma.user.findMany();
  }
}
