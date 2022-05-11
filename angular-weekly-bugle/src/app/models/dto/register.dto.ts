export class AuthRegisterDto {
    file:string;
    username: string;
    email: string;
    password: string;
    role:string;

    constructor() {
        this.file='';
        this.username = '';
        this.email = '';
        this.password = '';
        this.role='ADMIN';
    }
}