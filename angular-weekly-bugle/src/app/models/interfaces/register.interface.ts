export interface RegisterResponse {
    userId: string;
    username: string;
    email: string;
    avatar: string;
    created: Date;
    postList?: any;
    userRole: string;
    following?: any;
}
