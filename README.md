# ZNDropDownList

Use it like a UITableView

Init
```
ZNDropDownList *dropDownList = [[ZNDropDownList alloc] initWithFrame:CGRectMake(100, 100, 120, 40)];
[self.view addSubview:dropDownList];
dropDownList.dataSource = self;
dropDownList.delegate = self;
```

@Require
```
#pragma mark - ZNDropDownListDataSource
- (NSInteger)numberOfRowsIndropDownList:(ZNDropDownList *)dropDownList {
    return self.arrayList.count;
}
static NSString *reuseId = @"com.RootViewController.UITableViewCell";
- (UITableViewCell *)dropDownList:(ZNDropDownList *)dropDownList tableView:(UITableView *)tableView cellForRowAtIndex:(NSInteger)rowIndex {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.arrayList[rowIndex];
    return cell;
}

#pragma mark - ZNDropDownListDelegate
- (NSString *)dropDownList:(ZNDropDownList *)dropDownList didSelectRowAtIndex:(NSInteger)rowIndex {
    return self.arrayList[rowIndex];
}
```
