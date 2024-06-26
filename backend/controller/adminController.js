const adminModel = require("../model/adminModel");
const authModel = require("../model/authModel");
const jwt = require("jsonwebtoken");
const postsModel = require("../model/postsModel");
const bidModel = require("../model/bidModel");
const contractModel = require("../model/contract");
exports.loginAdmin = async (req, res) => {
  try {
    const data = await adminModel.find({ email: req.body.email });
    if (data != "") {
      if (data[0].password == req.body.password) {
        const token = jwt.sign(
          { email: data[0].email },
          process.env.SECRET_KEY
        );
        res.status(200).json({
          status: "success",
          data,
          token,
        });
      } else {
        res.status(200).json({
          status: "false",
          message: "Password incorrect",
        });
      }
    } else {
      res.status(200).json({
        status: "false",
        message: "Admin Not Found",
      });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({
      error: error.toString(),
    });
  }
};

exports.allSeller = async (req, res) => {
  try {
    // if (req.user.email === 'sahil' || req.user.email == 'utsav') {
    const data = await authModel.find({ role: "seller" });
    res.status(200).json({
      status: "success",
      data,
    });
    // } else {
    //   res.status(400).json({
    //     status: "false",
    //     message: "You are Admin but not allow to Access"
    //   })
    // }
  } catch (error) {
    console.log(error);
    res.status(500).json({
      error: error.toString(),
    });
  }
};

exports.allBuyer = async (req, res) => {
  try {
    if (req.user.email === "sahil" || req.user.email == "utsav") {
      const data = await authModel.find({ role: "buyer" });
      res.status(200).json({
        status: "success",
        data,
      });
    } else {
      res.status(400).json({
        status: "false",
        message: "You are Admin but not allow to Access",
      });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({
      error: error.toString(),
    });
  }
};
exports.allClient = async (req, res) => {
  try {
    if (req.user.email === "sahil" || req.user.email == "utsav") {
      const data = await authModel.find();
      res.status(200).json({
        status: "success",
        data,
      });
    } else {
      res.status(400).json({
        status: "false",
        message: "You are Admin but not allow to Access",
      });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({
      error: error.toString(),
    });
  }
};

exports.adminViewPosts = async (req, res) => {
  try {
    if (req.user.email === "sahil" || req.user.email == "utsav") {
      const data = await postsModel.find();
      res.status(200).json({
        status: "success",
        data,
      });
    } else {
      res.status(400).json({
        status: "false",
        message: "You are Admin but not allow to Access",
      });
    }
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
};

exports.adminViewBids = async (req, res) => {
  try {
    if (req.user.email === "sahil" || req.user.email == "utsav") {
      const data = await bidModel.find();
      res.status(200).json({
        status: "success",
        data,
      });
    } else {
      res.status(400).json({
        status: "false",
        message: "You are Admin but not allow to Access",
      });
    }
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
};

exports.sellerDetails = async (req, res) => {
  try {
    if (req.user.email === "sahil" || req.user.email == "utsav") {
      const data = await authModel.findById({ _id: req.params.id });
      if (data.role == "seller") {
        res.status(200).json({
          status: "success",
          data,
        });
      } else {
        res.status(400).json({
          status: "false",
          message: "Seller not found",
        });
      }
    } else {
      res.status(400).json({
        status: "false",
        message: "You are Admin but not allow to Access",
      });
    }
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
};
exports.buyerDetails = async (req, res) => {
  try {
    if (req.user.email === "sahil" || req.user.email == "utsav") {
      const data = await authModel.findById({ _id: req.params.id });
      if (data.role == "buyer") {
        res.status(200).json({
          status: "success",
          data,
        });
      } else {
        res.status(400).json({
          status: "false",
          message: "Buyer not found",
        });
      }
    } else {
      res.status(400).json({
        status: "false",
        message: "You are Admin but not allow to Access",
      });
    }
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
};

exports.viewAllContracts = async (req,res)=>{
  try {
    const data =await contractModel.find({}).populate('buyer_id').populate('seller_id')
    if(data != ''){
      res.status(200).json({
        status:true,
        data:data
      })
    }else{
      res.status(200).json({
        status:false,
        msg:"Data not found!"
      })
    }
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
}

exports.viewContract = async(req,res)=>{
  try {
    const data =await contractModel.find({_id:req.params.id}).populate('buyer_id').populate('seller_id')
    if(data != ''){
      res.status(200).json({
        status:true,
        data:data
      })
    }else{
      res.status(200).json({
        status:false,
        msg:"Data not found!"
      })
    }
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
}

exports.chart = async (req, res) => {
  try {
    const data = await authModel.aggregate([
      {
        $group: {
          _id: {
            month: { $month: "$createdAt" },
          },
          totalSellers: {
            $sum: {
              $cond: [{ $eq: ["$role", "seller"] }, 1, 0],
            },
          },
          totalBuyers: {
            $sum: {
              $cond: [{ $eq: ["$role", "buyer"] }, 1, 0],
            },
          },
        },
      },
      {
        $project: {
          _id: 0,
          month: {
            $let: {
              vars: {
                monthsInString: [
                  null,
                  "Jan",
                  "Feb",
                  "Mar",
                  "Apr",
                  "May",
                  "Jun",
                  "Jul",
                  "Aug",
                  "Sep",
                  "Oct",
                  "Nov",
                  "Dec",
                ],
              },
              in: {
                $arrayElemAt: ["$$monthsInString", "$_id.month"],
              },
            },
          },
          seller: "$totalSellers",
          buyer: "$totalBuyers",
        },
      },
      {
        $sort: { month: 1 },
      },
    ]);
    res.status(200).json({
      status: "success",
      data,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

//
exports.updatebuyer = async (req, res) => {
  try {
    const id = req.params.id;
    if (id) {
      if (req.user.email === "sahil" || req.user.email == "utsav") {
        const buyer = await authModel.findById(id);
        if (buyer.isDeleted == false) {
          await authModel.findByIdAndUpdate(id, req.body);
          const data = await authModel.findById(id);
          res.status(200).json({
            status: "success",
            data,
          });
        } else {
          res.status(200).json({
            status: "false",
            message: "buyer is deleted ",
          });
        }
      } else {
        res.status(200).json({
          status: "false",
          message: "login first",
        });
      }
    } else {
      res.status(200).json({
        status: "false",
        message: "id is not defined",
      });
    }
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
};

exports.deleteseller = async (req, res) => {
  try {
    const id = req.params.id;
    if (id) {
      if (req.user.email === "sahil" || req.user.email == "utsav") {
        const seller = await authModel.findById(id);
        if (!seller.isDeleted) {
          await authModel.findByIdAndUpdate(id, { isDeleted: true });
          const data = await authModel.findById(id);
          res.status(200).json({
            status: true,
            message: "seller deleted successfully",
            data,
          });
        } else {
          res.status(400).json({
            status: false,
            message: "seller Already deleted",
          });
        }
      } else {
        res.status(400).json({
          status: false,
          message: "login first",
        });
      }
    } else {
      res.status(400).json({
        status: false,
        message: "id is required",
      });
    }
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
};

exports.updateseller = async (req, res) => {
  try {
    const id = req.params.id;
    if (id) {
      if (req.user.email === "sahil" || req.user.email == "utsav") {
        const seller = await authModel.findById(id);
        if (seller.isDeleted == false) {
          await authModel.findByIdAndUpdate(id, req.body);
          const data = await authModel.findById(id);
          res.status(200).json({
            status: "success",
            data,
          });
        } else {
          res.status(200).json({
            status: "false",
            message: "seller is deleted ",
          });
        }
      } else {
        res.status(200).json({
          status: "false",
          message: "login first",
        });
      }
    } else {
      res.status(200).json({
        status: "false",
        message: "id is not defined",
      });
    }
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
};

exports.deletebuyer = async (req, res) => {
  try {
    const id = req.params.id;
    if (id) {
      if (req.user.email === "sahil" || req.user.email == "utsav") {
        const buyer = await authModel.findById(id);
        if (!buyer.isDeleted) {
          await authModel.findByIdAndUpdate(id, { isDeleted: true });
          const data = await authModel.findById(id);
          res.status(200).json({
            status: true,
            message: "buyer deleted successfully",
            data,
          });
        } else {
          res.status(400).json({
            status: false,
            message: "buyer Already deleted",
          });
        }
      } else {
        res.status(400).json({
          status: false,
          message: "login first",
        });
      }
    } else {
      res.status(400).json({
        status: false,
        message: "id is required",
      });
    }
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
};

exports.allDeleteClient = async (req, res) => {
  try {
    if (req.user.email === "sahil" || req.user.email == "utsav") {
      const data = await authModel.find({ isDeleted: true });
      if (data != "") {
        res.status(200).json({
          status: "success",
          data,
        });
      } else {
        res.status(400).json({
          status: false,
          msg: "Failed to fetch",
        });
      }
    } else {
      res.status(400).json({
        status: false,
        message: "login first",
      });
    }
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
};

exports.restoreClient = async (req, res) => {
  try {
    const id = req.params.id;
    if (id) {
      if (req.user.email === "sahil" || req.user.email == "utsav") {
        const client = await authModel.findById({ _id: req.params.id });
        if (client.isDeleted == true) {
          await authModel.findByIdAndUpdate(id, { isDeleted: false });
          const data = await authModel.findById(id);
          res.status(200).json({
            status: "succes",
            data,
          });
        } else {
          res.status(400).json({
            status: false,
            message: "client is not deleted",
          });
        }
      } else {
        res.status(400).json({
          status: false,
          message: "login first",
        });
      }
    } else {
      res.status(400).json({
        status: false,
        message: "id is required",
      });
    }
  } catch (error) {
    res.status(500).json({
      error: error.message,
    });
  }
};
