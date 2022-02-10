    # Pipe

RxJS v5.5 才有的語法

```typescript
import { catchError, tap, map } from 'rxjs/operators';

    getOrder(orderId: number): Observable<Order> {
       return this.httpClient.get<Order>(environment.apiHost + "order/detail/" + orderId, { observe: 'response' })
         .pipe(
          map(resp => resp.body),
          tap(_ => this.log('get order id:' + orderId)),
          catchError(error => this.handleError<Order>('get order'))
         );
    }

    private handleError<T>(operation = 'operation', result?: T) {
        return (error: any): Observable<T> => {

            this.log(`${operation} failed: ${error.message}`);
            return of(result as T);
        };
    }

    private log(message: string) {
        console.log(message);
    }
```

- https://blog.angularindepth.com/reading-the-rxjs-6-sources-map-and-pipe-94d51fec71c2

- https://wellwind.idv.tw/blog/2018/11/13/mastering-angular-29-angular-with-rxjs-basic/