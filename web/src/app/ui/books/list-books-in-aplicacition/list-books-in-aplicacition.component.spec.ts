import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListBooksInAplicacitionComponent } from './list-books-in-aplicacition.component';

describe('ListBooksInAplicacitionComponent', () => {
  let component: ListBooksInAplicacitionComponent;
  let fixture: ComponentFixture<ListBooksInAplicacitionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ListBooksInAplicacitionComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ListBooksInAplicacitionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
