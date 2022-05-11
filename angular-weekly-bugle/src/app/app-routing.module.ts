import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';
import { SubpostListComponent } from './subpost-list/subpost-list.component';

const routes: Routes = [
  {path: '',pathMatch: 'full', redirectTo: '/login'},
  {path: 'register',component: RegisterComponent},
  {path: 'login',component:LoginComponent},
  {path: 'subpost',component:SubpostListComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
