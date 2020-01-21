import { Component, Output } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
	@Output()
  title = 'KnowledgeSearch';
	public static SERVER_URL:string = "http://127.0.0.1:8000/";
}
