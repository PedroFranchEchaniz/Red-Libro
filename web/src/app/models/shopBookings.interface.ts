export interface BookingResponse {
    content: Booking[];
    pageable: Pageable;
    last: boolean;
    totalPages: number;
    totalElements: number;
    first: boolean;
    size: number;
    number: number;
    sort: Sort;
    numberOfElements: number;
    empty: boolean;
}

export interface Booking {
    codigo: string;
    fechaReserva: Date;
    fechaExpiacion: Date;
    nombreUsuario: string;
    titulo: string;
    portada: string;
    idbn: string;
    lat: string;
    lon: string;
}

export interface Pageable {
    pageNumber: number;
    pageSize: number;
    sort: Sort;
    offset: number;
    unpaged: boolean;
    paged: boolean;
}

export interface Sort {
    empty: boolean;
    sorted: boolean;
    unsorted: boolean;
}
