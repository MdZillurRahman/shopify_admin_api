document.addEventListener("DOMContentLoaded", function() {
    const buttons = document.querySelectorAll('.toggle-button');
  
    buttons.forEach(function(button) {
      button.addEventListener('click', function() {
        button.classList.toggle("bg-primary");
        button.classList.toggle("text-white");
        const target = button.dataset.target;
        const inputField = document.querySelector(`#${target}`);
        // if (inputField.style.display === 'none') {
        //   inputField.style.display = 'block';
        // } else {
        //   inputField.style.display = 'none';
        // }
        inputField.classList.toggle("d-none")
        // console.log(inputField)
      });
    });

    const productPrice = ()=>{
      if(document.querySelector(".variantPart .form-group")){
        document.querySelector("#proPrice").classList.add("d-none");
      }else{
        document.querySelector("#proPrice").classList.remove("d-none");
      }
    }


    const add_variant = document.querySelector(".add_variant");
    add_variant.addEventListener("click", (e)=>{
      let val = Number(e.target.dataset.value) + 1;
      e.target.dataset.value = val;
      document.querySelector(".count").value = val;

      let newElement =
        `<div class="form-group">
          <label for="variant_${val}_title">Variant ${val} Title</label>
          <input type="text" id="variant_${val}_title" name="variant_${val}_title" class="form-control"/>
          <label for="variant_${val}_price">Variant ${val} Price</label>
          <input type="number" id="variant_${val}_price" name="variant_${val}_price" class="form-control"/>
          <label for="variant_${val}_options">Variant ${val} Options</label>
          <input type="text" id="variant_${val}_options" name="variant_${val}_options" class="form-control"/>
          <p class="text-secondary">Please input your options using comma-separated</p>
          <p class="btn btn-danger mt-2 w-full remove_variant">Remove this variant</p>
        </div>`
      

      let variantPart = 
      `<div class="variantPart">
        ${newElement}
      </div>
      `

      console.log(newElement);

      if(document.querySelector(".variantPart")){
        document.querySelector(".variantPart").insertAdjacentHTML("beforeEND", newElement)
      }else{
        document.querySelector("[type='submit']").insertAdjacentHTML("beforebegin", variantPart);
      }
      productPrice();


    })

    window.addEventListener("click",(e)=>{
      if(e.target.classList.contains("remove_variant")){
        let val = e.target.closest(".variantPart").querySelectorAll(".form-group").length - 1;
        add_variant.dataset.value = val;
        document.querySelector(".count").value = val;
        if(val === 0){
          e.target.closest(".variantPart").outerHTML = "";
        }else{
          e.target.closest(".form-group").outerHTML = "";
        }
        productPrice();
      }
    })


  });
  