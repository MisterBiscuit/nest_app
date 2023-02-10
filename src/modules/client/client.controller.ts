import { CacheInterceptor, CacheKey, CacheTTL, Controller, Get, Param, UseInterceptors } from '@nestjs/common';

import { ClientService } from './client.service';

@Controller('client')
export class ClientController {
  constructor(private readonly service: ClientService) {}

  @UseInterceptors(CacheInterceptor)
  @CacheKey('client-cache')
  @CacheTTL(30)
  @Get('/:id')
  async getClient(@Param('id') id: number): Promise<string> {
    return await this.service.getClient(+id);
  }
}
