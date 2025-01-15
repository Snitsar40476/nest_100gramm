import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { ValidationPipe } from '@nestjs/common';
import * as cookieParser from 'cookie-parser';

async function bootstrap() {
  const PORT = process.env.PORT || 7000;

  const app = await NestFactory.create(AppModule);

  const config = new DocumentBuilder()
    .setTitle('Backend 100GRAMM')
    .setDescription('Документация REST API')
    .setVersion('0.0.1')
    .addTag('Powered by Andrey_Snitsar')
    .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('/api/docs', app, document);

  app.useGlobalPipes(new ValidationPipe());
  app.use(cookieParser());

  app.enableCors({
    credentials: true,
    origin: true,
    methods: ['GET', 'POST', 'DELETE'],
    allowedHeaders: [
      'Content-Type',
      'Authorization',
      'Cookie',
      'Public-key',
      'Aes-client-key',
      'User-key',
    ],
  });

  await app.listen(PORT, () => console.log(`Server started on port = ${PORT}`));
}

void bootstrap();
