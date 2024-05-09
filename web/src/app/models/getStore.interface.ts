export interface GetStoreResponse {
    content: Store[]
    pageable: Pageable
    last: boolean
    totalPages: number
    totalElements: number
    size: number
    number: number
    sort: Sort2
    first: boolean
    numberOfElements: number
    empty: boolean
}

export interface Store {
    pk: string
    isbn: string
    titulo: string
    cantidad: number
    uuid: string
}

export interface Pageable {
    pageNumber: number
    pageSize: number
    sort: Sort
    offset: number
    paged: boolean
    unpaged: boolean
}

export interface Sort {
    empty: boolean
    sorted: boolean
    unsorted: boolean
}

export interface Sort2 {
    empty: boolean
    sorted: boolean
    unsorted: boolean
}