import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { SubpostListComponent } from './components/subpost-list/subpost-list.component';
import { SideMenuComponent } from './components/side-menu/side-menu.component';
import { PostListComponent } from './components/post-list/post-list.component';
import { UserListComponent } from './components/user-list/user-list.component';
import { LoginGuardService } from './service/loginGuardService';

const routes: Routes = [
  {path: '',pathMatch: 'full', redirectTo: 'login'},
  {path: 'login',component:LoginComponent },
  {path: 'subpost',component:SubpostListComponent},
  {path: 'post',component:PostListComponent},
  {path: 'user',component:UserListComponent},
  {path: 'menu', component:SideMenuComponent, canActivate:[LoginGuardService]},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
