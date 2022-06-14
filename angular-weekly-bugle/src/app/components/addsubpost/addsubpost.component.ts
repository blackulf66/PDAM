import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { SubPostDto } from 'src/app/model/dto/subpost.dto';
import { SubPostService } from 'src/app/service/subpost.service';
import {HttpClient} from '@angular/common/http';


@Component({
  selector: 'app-addsubpost',
  templateUrl: './addsubpost.component.html',
  styleUrls: ['./addsubpost.component.css']
})
export class AddsubpostComponent implements OnInit {

   

   


  addSubpostForm = new FormGroup({
    nombre: new FormControl(''),
    descripcion: new FormControl(''),
    file: new FormControl(''),
  });


  addsubpostDto = new SubPostDto();
  constructor(private subpostService: SubPostService) { }


  ngOnInit(): void {
  }

  doaddSubpost() {
    this.subpostService.AddSubpost(this.addsubpostDto);
  }

}
