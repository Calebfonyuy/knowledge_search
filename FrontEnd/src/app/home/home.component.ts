import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { AppComponent } from '../app.component';
import { Router } from '@angular/router';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
	public propositions:any[] = [];
	private submit_link:string = "/educative_search";
	private search:string;

  constructor(private http: HttpClient, private router:Router) { console.log(router)}

  ngOnInit() {
	  this.http.get(AppComponent.SERVER_URL+"frequent", {responseType: 'json'}).subscribe((data:any)=>{
  		this.propositions= data;
  		console.log(this.propositions);
  	});
  }

	private changeLink(event){
		if(event.target.checked){
			if(event.target.value==1) this.submit_link = "/educative_search"
			else this.submit_link = "/pure_google_results"
		}
	}

	private submitForm(){
		this.router.navigate([this.submit_link], { queryParams: {search: this.search}})
	}

}
