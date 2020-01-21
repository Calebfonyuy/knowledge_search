import { Component, OnInit, Input } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HeaderComponent } from '../header/header.component';
import { AppComponent } from '../app.component';
import { HttpClient, HttpParams } from '@angular/common/http';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent implements OnInit {
	private propositions:string[] = [];
	private pages:number[] = [1,2,3,4,5,6,7,8,9,10];
	private large_search:boolean = true;
	@Input('type')
	private search_type:number;
	private search_term:string;
	public results:any[] = [];
	private search_url:string;
	private current_page:number;
	public loading:boolean = false;
	public load_error:boolean = false;
  constructor(private route:ActivatedRoute, private http: HttpClient) { }

  ngOnInit() {
	  this.search_type = this.route.data._value['type'];
	  var values = this.route.queryParams._value;
	  this.search_term = values.search;
	  console.log("search type: ", this.search_type);
	  console.log(HeaderComponent.language);
	  this.http.get(AppComponent.SERVER_URL+"frequent", {responseType: 'json'}).subscribe((data:any)=>{
  		this.propositions= data;
  	});
  }

	private performSearch(page){
		this.loading = true;
		this.load_error = false;
		this.search_url = AppComponent.SERVER_URL
		this.current_page = page;
		this.results = []
		switch(this.search_type){
			case 1:
				this.search_url += "filtered_search";
				break;
			case 2:
				this.search_url += "raw_search";
				break;
			case 3:
				this.search_url += "scrapped_search"
				break;
		}
		var parameters = new HttpParams().set('word', this.search_term)
							.set('lang', HeaderComponent.language)
							.set('page', page)
		this.http.get(this.search_url, {responseType: 'json', params: parameters}).subscribe((data:any)=>{
			this.results = data;
			this.loading = false;
		},
		(error)=>{
			this.load_error = true;
			this.loading = false;
		});
		this.large_search= false;
	}

	private previousPage(){
		this.performSearch(this.current_page-1);
	}

	private nextPage(){
		this.performSearch(this.current_page+1);
	}
}
