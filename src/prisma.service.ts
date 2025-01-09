import { Injectable, OnModuleDestroy } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleDestroy {
  constructor() {
    super();
  }

  // Quando o módulo for destruído, desconecte-se do Prisma
  onModuleDestroy() {
    this.$disconnect();
  }
}
