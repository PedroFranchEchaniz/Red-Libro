export interface UserLoginResponse {
    id: string;
    username: string;
    fullName: string;
    roles: string[];
    token: string;
}