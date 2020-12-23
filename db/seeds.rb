if Typecategory.count == 0
  Typecategory.create([
    {type_name: '短期留学'},
    {type_name: '高校留学'},
    {type_name: '大学留学'},
    {type_name: '大学院留学'},
    {type_name: 'その他'}
  ])
end

if Areacategory.count == 0
   Areacategory.create([
    {area_name: 'アジア'},
    {area_name: 'オセアニア・南太平洋'},
    {area_name: 'カリブ・中南米'},
    {area_name: 'ヨーロッパ'},
    {area_name: '中近東・アフリカ'},
    {area_name: '北米'},
    {area_name: 'その他'}
   ])
end

if Contribution.count == 0
   Contribution.create({
     body: 'Welcome to Glarch',
     area: "Tokyo",
     public:'t',
     user_id: 1,
     areacategory_id: 7,
     typecategory_id: 5
   })
end
