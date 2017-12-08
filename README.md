# ZNDropDownList

Use it like a UITableView

###Init

```
    ZNDropDownList *dropDownList = [[ZNDropDownList alloc] initWithFrame:CGRectMake(100, 100, 120, 40)];
    [self.view addSubview:dropDownList];
    dropDownList.dataSource = self;
    dropDownList.delegate = self;
```

```
    #pragma mark - ZNDropDownListDataSource
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.arrayList.count;
    }

    static NSString *reuseId = @"com.RootViewController.UITableViewCell";
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = self.arrayList[indexPath.row];
        return cell;
    }
    #pragma mark - ZNDropDownListDelegate
    - (NSString *)dropDownList:(ZNDropDownList *)dropDownList didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        return self.arrayList[indexPath.row];
    }
```
