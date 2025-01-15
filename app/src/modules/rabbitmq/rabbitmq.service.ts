import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import {
  ClientProxy,
  ClientProxyFactory,
  Transport,
} from '@nestjs/microservices';

@Injectable()
export class RabbitmqService {
  constructor(private readonly configService: ConfigService) {}

  async createClient(queue: string): Promise<ClientProxy> {
    return ClientProxyFactory.create({
      transport: Transport.RMQ,
      options: {
        urls: [
          this.configService.get('RABBITMQ_URL_1') as string,
          this.configService.get('RABBITMQ_URL_2') as string,
          this.configService.get('RABBITMQ_URL_3') as string,
        ],
        queue: queue,
        queueOptions: {
          durable: true,
        },
      },
    });
  }
}
