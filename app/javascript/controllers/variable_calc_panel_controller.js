import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["category", "categoryInfo", 'incomingVariable']
  connect() {
    this.showPanel(this.categoryTarget.value)
    // this.element.textContent = "Hello World!"
  }

  showPanel(category){
    switch(category){
      case "render":
        this.categoryInfoTarget.innerHTML = '使用 <a href="https://liquid.bootcss.com/">liquid 模版</a>语法, 即用{{}} 包裹变量, 如 "My {{request.method}}" 会渲染为 My GET </p>'
        break;
      case "regex":
        this.categoryInfoTarget.innerHTML = '使用正则, 取正则的第一哥括号, 如 ^(\d), 则输出为变量的第一个字符 '
      break;
      case "jsonpath":
        this.categoryInfoTarget.innerHTML = '使用JsonPath (<a href="https://gotest.hz.netease.com/doc/jie-kou-ce-shi/xin-zeng-yong-li/can-shu-xiao-yan/jsonpi-pei/jsonpathyu-fa.html">语法简介</a>)取值, 一般来源变量为 request.json  如值设置为 "$..a", 则为request.json 中的a节点数据'
        break;
      default:
      break;
    }
  }

  select(e){
    const category = e.target.value
    this.showPanel(category)

  }

  try(e) {
    e.preventDefault();


  }



}
