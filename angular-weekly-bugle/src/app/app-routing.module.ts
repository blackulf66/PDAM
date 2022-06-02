import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { SubpostListComponent } from './components/subpost-list/subpost-list.component';
import { SideMenuComponent } from './components/side-menu/side-menu.component';
import { PostListComponent } from './components/post-list/post-list.component';
import { UserListComponent } from './components/user-list/user-list.component';

const routes: Routes = [
  // {path: '',pathMatch: 'full', redirectTo: '/menu'},
  {path: 'subpost',component:SubpostListComponent},
  {path: 'post',component:PostListComponent},
  {path: 'user',component:UserListComponent},
  {path: 'menu',component:SideMenuComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
