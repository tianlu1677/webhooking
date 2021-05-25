import { Controller } from "stimulus"
import { Liquid } from 'liquidjs'
import jp from 'jsonpath/jsonpath.min'

export default class extends Controller {
  static targets = ["category", "categoryInfo", 'incomingVariable', 'sourceVariablePanel', 'filterValue', 'mockData', 'mockAnswer', 'tryPanel']
  connect() {
    this.showPanel(this.categoryTarget.value, false)
  }

  showPanel(category, need_clean_filter_value = true) {
    var show = 'flex'
    switch (category) {
      case "render":
        this.categoryInfoTarget.innerHTML = '使用 <a href="https://liquid.bootcss.com/">liquid 模版</a>语法, 即用{{}} 包裹变量, 如 "My {{request.method}}" 会渲染为 My GET </p>'
        show = 'none'
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
    if (need_clean_filter_value){
      this.filterValueTarget.value = ''
    }
    this.sourceVariablePanelTarget.style.display = show

    if (category === 'render'){
      this.tryPanelTarget.style.display = 'none'
    }else{
      this.tryPanelTarget.style.display = 'block'
    }

  }

  select(e) {
    const category = e.target.value
    this.showPanel(category)

  }

  calAnswer(category, source, value) {
    return new Promise((resolve, reject) => {
      try {
        switch (category) {
          case "render":
            const engine = new Liquid()
            const tpl = engine.parse(source)
            engine.render(tpl, value).then((e) => { resolve(e) })
            break;
          case "regex":
            var re = new RegExp(value);
            var answers = re.exec(source)
            if (answers == null) {
              resolve("")
            } else {
              resolve(answers[0])
            }
            break;
          case "jsonpath":
            var jp = require('jsonpath');
            var json = JSON.parse(source)
            var answer = jp.query(json, value);
            resolve(answer[0])
            break;
          default:
            break;
        }
      }
      catch (e) {
        console.log(e)
        reject("解析错误")
      }
    })
  }

  try(e) {
    e.preventDefault();
    const category = this.categoryTarget.value
    const val = this.filterValueTarget.value
    const source = this.mockDataTarget.value



    this.calAnswer(category,source,val).then((answer) => {
      console.log(answer)
      this.mockAnswerTarget.innerHTML = answer
    }).catch((e) => {
      console.log(e)
    })
  }

  fetchVariablesFromData(data){
    reg = /\{\{([a-zA-Z0-9\. ]+)\}\}/g
    var tmp = null
    variables = []
    while((tmp = reg.exec(data)) !== null){
      console.log(tmp)
      variables.push(tmp[0])
    }
    return variables
  }

}
