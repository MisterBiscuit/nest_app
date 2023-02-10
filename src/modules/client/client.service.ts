import { Injectable } from '@nestjs/common';

@Injectable()
export class ClientService {
  public getClient(id: number): Promise<string> {
    return Promise.resolve(`Client #${id}`);
  }
}
