import {
  WebSocketGateway,
  ConnectedSocket,
  OnGatewayConnection,
  OnGatewayDisconnect,
  WebSocketServer,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import * as fs from 'fs';
import * as path from 'path';

@WebSocketGateway(3002, { namespace: '/file-watch' })
export class FileWatchGateway
  implements OnGatewayConnection, OnGatewayDisconnect
{
  @WebSocketServer()
  server: Server;

  private readonly watchPath = path.resolve(
    'C:\\Users\\IJS\\Desktop\\watch-folder', // 감시할 폴더 경로
  );

  private filesToWatch: Record<string, boolean> = {}; // 감시할 파일 목록

  handleConnection(client: Socket) {
    console.log(`Client connected: ${client.id}`);
    this.startFileWatcher(); // 클라이언트가 연결되면 파일 감시 시작
  }

  handleDisconnect(client: Socket) {
    console.log(`Client disconnected: ${client.id}`);
  }

  startFileWatcher() {
    // 초기 파일 목록 읽기
    fs.readdir(this.watchPath, (err, files) => {
      if (err) {
        console.error('Error reading directory:', err);
        return;
      }

      files.forEach((file) => {
        const filePath = path.join(this.watchPath, file);
        this.filesToWatch[file] = true; // 기존 파일 추가
        this.watchFile(filePath); // 파일 감시 시작
      });
    });

    // 폴더 감시 시작
    fs.watch(this.watchPath, (eventType, filename) => {
      if (filename) {
        const filePath = path.join(this.watchPath, filename);
        if (eventType === 'rename') {
          if (this.filesToWatch[filename]) {
            // 파일이 삭제된 경우
            console.log(`${filename}가 삭제되었습니다.`);
            delete this.filesToWatch[filename]; // 삭제된 파일 기록 제거
            this.broadcastFileChange({
              filename,
              eventType: 'deleted',
              modifiedTime: new Date(),
            });
          } else {
            // 새 파일이 생성된 경우
            console.log(`${filename}가 생성되었습니다.`);
            this.filesToWatch[filename] = true; // 새 파일 기록 추가
            this.watchFile(filePath); // 새 파일 감시 시작
            this.broadcastFileChange({
              filename,
              eventType: 'added',
              modifiedTime: new Date(),
            });
          }
        }
      }
    });
  }

  watchFile(filePath: string) {
    // 파일 변경 감지
    fs.watchFile(filePath, (curr, prev) => {
      if (curr.mtime !== prev.mtime) {
        console.log(`${path.basename(filePath)}가 변경되었습니다.`);
        this.broadcastFileChange({
          filename: path.basename(filePath),
          eventType: 'changed',
          modifiedTime: curr.mtime,
        });
      }
    });
  }

  // 변경 사항을 모든 클라이언트에 브로드캐스트
  broadcastFileChange(data: {
    filename: string;
    eventType: string;
    modifiedTime: Date;
  }) {
    const message = {
      event: 'fileChanged',
      data,
    };
    if (this.server) {
      this.server.emit('fileChanged', message);
    } else {
      console.error('WebSocket server is not initialized.');
    }
  }
}
