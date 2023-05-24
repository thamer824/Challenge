const express = require('express');
const app = express();
const { v4: uuidv4 } = require('uuid');
const { dynamoClient, TABLE_NAME } = require('./db.config');
app.use(express.json());
app.use(express.urlencoded({ extended:true}));

const user = [];




app.listen(2000,()=>{
    console.log('listening')
})



//post: 
let counter = 0;
app.post("/api/add",(req,res)=>{
   console.log("Result",req.body);
   const pdata= {
    id: counter++,
    "name":req.body.name,
    "email":req.body.email,
    "des":req.body.des
   };
   const params = {
    TableName: TABLE_NAME,
    Item: pdata
  };

  dynamoClient.put(params, (error, data) => {
    if (error) {
      console.error('Error adding user to DynamoDB:', error);
      res.status(500).send({
        status: 500,
        message: 'Error adding user to DynamoDB',
      });
    } else {
      console.log('User added to DynamoDB:', pdata);
      user.push(pdata);
      res.status(200).send({
        status: 200,
        message: 'Added successfully',
        user: pdata,
      });
    }
  });

});



app.get("/api/get",(req,res)=>{
    if(user.length>0){
        res.status(200).send({
            'status_code':200,
            'products':user
        })
    }else{
        res.status(200).send({
            'status_code':200,
            'products': []
        })
    }
 
 })