export interface AuthSignUpResponse {
    nombre: string;
    apellidos: string;

    id: string;
    nick: string;
    email: string;
    fechaNacimiento: string;
    avatar: string;
    userRoles: string;
}

export interface AuthLoginResponse{
    id: string;
    nick: string;
    email: string;
    nombre: string;
    avatar: string;
    role: string;
    token: string;
}