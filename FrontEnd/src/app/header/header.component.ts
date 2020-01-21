import { Component, OnInit, Input } from '@angular/core';


@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {
	@Input('title')
	private title:string;

	public static language:string="lang_en";
  constructor() { }

  ngOnInit() {
  }

	private updateLanguage(event){
		HeaderComponent.language = event.target.value;
	}
}
