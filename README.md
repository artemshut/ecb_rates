# ecb_rates

Rates gem for CNB

## INSTALL

```
$ gem install ecb_rates
```
## USAGE EXAMPLE


```
# date should be in format '1.1.2015'
ECBRates.rates_for 'currency_name', 'date'
```
As improvements for future we could add a migration generator,
which adds xml response to preferences table or special file and updates it every day
at 3PM to get a better performance.
