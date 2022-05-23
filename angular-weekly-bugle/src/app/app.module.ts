import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MaterialImportsModule } from './module/material-imports.module';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { RegisterComponent } from './register/register.component';
import { LoginComponent } from './login/login.component';
import { SideMenuComponent } from './components/side-menu/side-menu.component';
import { SubpostItemComponent } from './components/subPost-item/subpost-item.component';
import { SubpostListComponent } from './components/subpost-list/subpost-list.component';
import { MatIconModule } from '@angular/material/icon';
import { RouterModule } from '@angular/router';
import { MatDialogModule } from '@angular/material/dialog';

@NgModule({
  declarations: [
    AppComponent,
    RegisterComponent,
    LoginComponent,
    SideMenuComponent,
    SubpostItemComponent,
    SubpostListComponent,
    
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MaterialImportsModule,
    HttpClientModule,
    FormsModule,
    MatIconModule,
    RouterModule,
    MatDialogModule
    
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
