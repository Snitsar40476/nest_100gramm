-- CreateTable
CREATE TABLE "ChatRoom" (
    "id" SERIAL NOT NULL,
    "chat_room_key" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "chat_room_creator" TEXT NOT NULL,
    "total_messages" INTEGER NOT NULL DEFAULT 0,
    "last_message" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ChatRoom_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Message" (
    "id" SERIAL NOT NULL,
    "message_key" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "author_id" INTEGER NOT NULL,
    "chat_room_id" INTEGER NOT NULL,
    "text_data" TEXT,
    "audio_data" TEXT,
    "image_data" TEXT,
    "video_data" TEXT,
    "file_data" TEXT,
    "is_read" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Message_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Role" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Token" (
    "id" SERIAL NOT NULL,
    "token" TEXT NOT NULL,
    "exp" TIMESTAMP(3) NOT NULL,
    "user_key" TEXT NOT NULL,
    "user_agent" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Token_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnreadMessage" (
    "id" SERIAL NOT NULL,
    "chat_room_id" INTEGER NOT NULL,
    "message_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UnreadMessage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "user_key" TEXT NOT NULL,
    "firstname" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "login" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "about_user" TEXT,
    "path_avatar" TEXT,
    "view_email" INTEGER NOT NULL DEFAULT 2,
    "view_online" INTEGER NOT NULL DEFAULT 2,
    "view_shipment" INTEGER NOT NULL DEFAULT 2,
    "view_avatar" INTEGER NOT NULL DEFAULT 2,
    "if_calls" INTEGER NOT NULL DEFAULT 2,
    "if_channels" INTEGER NOT NULL DEFAULT 2,
    "if_code_password" BOOLEAN NOT NULL DEFAULT false,
    "code_password" TEXT,
    "double_authentication" BOOLEAN NOT NULL DEFAULT false,
    "language_id" INTEGER NOT NULL DEFAULT 0,
    "theme_id" INTEGER NOT NULL DEFAULT 0,
    "color_id" INTEGER NOT NULL DEFAULT 0,
    "message_color_id" INTEGER NOT NULL DEFAULT 0,
    "path_background_chatroom_id" TEXT,
    "sending_enter" BOOLEAN NOT NULL DEFAULT true,
    "double_click_message" BOOLEAN NOT NULL DEFAULT true,
    "reaction_to_message" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserChatRoom" (
    "user_id" INTEGER NOT NULL,
    "chat_room_id" INTEGER NOT NULL,

    CONSTRAINT "UserChatRoom_pkey" PRIMARY KEY ("user_id","chat_room_id")
);

-- CreateTable
CREATE TABLE "UserKeys" (
    "id" SERIAL NOT NULL,
    "aes_key" TEXT NOT NULL,
    "public_key" TEXT NOT NULL,
    "user_agent" TEXT NOT NULL,
    "user_id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserKeys_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserRoles" (
    "user_id" INTEGER NOT NULL,
    "role_id" INTEGER NOT NULL,

    CONSTRAINT "UserRoles_pkey" PRIMARY KEY ("user_id","role_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ChatRoom_chat_room_key_key" ON "ChatRoom"("chat_room_key");

-- CreateIndex
CREATE UNIQUE INDEX "Message_message_key_key" ON "Message"("message_key");

-- CreateIndex
CREATE UNIQUE INDEX "Token_token_key" ON "Token"("token");

-- CreateIndex
CREATE UNIQUE INDEX "User_user_key_key" ON "User"("user_key");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_login_key" ON "User"("login");

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "Message_chat_room_id_fkey" FOREIGN KEY ("chat_room_id") REFERENCES "ChatRoom"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnreadMessage" ADD CONSTRAINT "UnreadMessage_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserChatRoom" ADD CONSTRAINT "UserChatRoom_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserChatRoom" ADD CONSTRAINT "UserChatRoom_chat_room_id_fkey" FOREIGN KEY ("chat_room_id") REFERENCES "ChatRoom"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserKeys" ADD CONSTRAINT "UserKeys_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserRoles" ADD CONSTRAINT "UserRoles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserRoles" ADD CONSTRAINT "UserRoles_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
