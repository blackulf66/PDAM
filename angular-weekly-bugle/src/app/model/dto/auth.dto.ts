export class AuthSignUpDto {
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
export class AuthLoginDto {
    email: string;
    password: string;

    constructor() {
        this.email = '';
        this.password = '';
    }
}