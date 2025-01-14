import { Test, TestingModule } from '@nestjs/testing';
import { AppController } from './app.controller';
import { AppService } from './app.service';

describe('AppController', () => {
  let appController: AppController;
  let appService: AppService;

  beforeEach(async () => {
    const mockAppService = {
      getHello: jest.fn().mockResolvedValue('Data from database'),
    };

    const app: TestingModule = await Test.createTestingModule({
      controllers: [AppController],
      providers: [{ provide: AppService, useValue: mockAppService }],
    }).compile();

    appController = app.get<AppController>(AppController);
    appService = app.get<AppService>(AppService);
  });

  it('should return data from the database', async () => {
    const result = await appController.getHello();
    expect(result).toBe('Data from database');
    expect(appService.getHello).toHaveBeenCalled();
  });
});
