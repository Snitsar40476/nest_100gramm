import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { RabbitmqModule } from '@rabbitmq/rabbitmq.module';
import { PrismaModule } from '@prisma/prisma.module';
import { RedisModule } from '@redis/redis.module';

@Module({
  controllers: [],
  imports: [
    ConfigModule.forRoot({
      envFilePath: '.env',
      isGlobal: true,
    }),
    RabbitmqModule,
    PrismaModule,
    RedisModule,
  ],
  providers: [],
})
export class AppModule {}
