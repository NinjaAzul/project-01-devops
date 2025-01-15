import { Injectable } from '@nestjs/common';

@Injectable()
export class PrismaService {
  // Serviço mockado temporariamente
  constructor() {
    console.log('Serviço Prisma mockado para testes');
  }
}
