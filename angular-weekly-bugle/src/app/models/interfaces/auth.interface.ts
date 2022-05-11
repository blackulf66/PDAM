export interface AuthLoginResponse {
    email: string;
    avatar: string;
    username: string;
    token: string;
    userRole: string;
    fecha: Date;
    subPosts: any[];
    posts: any[];
}