# Bogus

- 適合用來產生大量假資料
- 亦適用於單元測試


```cs
Faker<Passenger> faker = new();
faker.RuleFor(p => p.FirstName, f => f.Person.FirstName)
     .RuleFor(p => p.LastName, f => f.Person.LastName)
     .RuleFor(p => p.Email, f => f.Person.Email)
     .RuleFor(p => p.MailingCity, f => f.Address.City())
     .RuleFor(p => p.MailingCountry, f => f.Address.Country())
     .RuleFor(p => p.MailingState, f => f.Address.State())
     .RuleFor(p => p.MailingPostalCode, f => f.Address.ZipCode())
     .RuleFor(p => p.RewardsId, f => f.Rant.Review())
     .RuleFor(p => p.RewardMiles, f => f.Random.Number(int.MaxValue));

Passenger passenger = faker.Generate();
```