# custom validator

### 範例 Time 驗証

error key ： invalid-format

```js
const result = new FormGroup({});

result.setControl(
    'time',
    new FormControl(`${hour}:${minute}`, [
        (control: AbstractControl): ValidationErrors | null => {
            const timePattern = /^\d{2}:\d{2}$/;
            let isValid = timePattern.test(control.value);

            if (isValid) {
                const timeParts = control.value.split(':');
                const hour = timeParts[0];
                if (hour >= 24) {
                    isValid = false;
                }

                const minute = timeParts[1];
                if (minute >= 60) {
                    isValid = false;
                }
            }

            return isValid
            ? null
            : { 'invalid-format': { value: control.value } };
        },
    ]),
);
```