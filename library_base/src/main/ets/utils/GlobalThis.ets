import { common } from '@kit.AbilityKit';

// 构造单例对象
export class GlobalThis {
  private constructor() {};
  private static instance: GlobalThis;
  private _uiContexts = new Map<string, common.UIAbilityContext>();
  private value = '';

  public static getInstance(): GlobalThis {
    if (!GlobalThis.instance) {
      GlobalThis.instance = new GlobalThis();
    }
    return GlobalThis.instance;
  }

  getContext(key: string): common.UIAbilityContext | undefined {
    return this._uiContexts.get(key);
  }

  setContext(key: string, value: common.UIAbilityContext): void {
    this._uiContexts.set(key, value);
  }

  setValue(value:string){
    this.value = value
  }

  getValue():string{
    return this.value;
  }
}
