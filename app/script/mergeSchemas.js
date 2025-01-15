const fs = require('fs');
const path = require('path');

const modelsDir = path.join(__dirname, '../prisma', 'schema');
const schemaPath = path.join(__dirname, '../prisma', 'schema.prisma');

const modelFiles = fs.readdirSync(modelsDir);

let schema = `
generator client {
  provider = "prisma-client-js"
  previewFeatures = ["prismaSchemaFolder"]
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}
`;

modelFiles.forEach(file => {
  const model = fs.readFileSync(path.join(modelsDir, file), 'utf8');
  schema += model + '\n';
});

fs.writeFileSync(schemaPath, schema);
