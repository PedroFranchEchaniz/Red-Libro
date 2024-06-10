export type GetAllClientsResponse = AllClientsDto[]

export interface AllClientsDto {
    uuid: string
    username: string
    isEnable: boolean
}

