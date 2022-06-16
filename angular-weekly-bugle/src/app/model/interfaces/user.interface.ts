export interface PostList {
    imagenportada: string;
    postId: number;
    postName: string;
    description: string;
    userEntityId: string;
    createdDate: string;
    subpostsName: string;
    voteCount: number;
}

export interface Following {
    imagen: string;
    id: number;
    nombre: string;
    descripcion: string;
    createdDate: string;
    postList?: any;
    userEntityId: string;
}

export interface UserResponse {
    userId: string;
    username: string;
    email: string;
    avatar: string;
    created: Date;
    postList: PostList[];
    userRole: string;
    following: Following[];
}