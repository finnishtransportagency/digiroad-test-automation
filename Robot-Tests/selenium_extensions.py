# Matti Telenius       Sitowise Oy     2019

#import pyautogui as ag

from multiprocessing.sharedctypes import Value
from selenium.webdriver.common.action_chains import ActionChains
#from selenium.webdriver.common.touch_actions import TouchActions
from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.common.keys import Keys
import requests
#from pyproj import Proj, transform

#from selenium.webdriver.firefox.firefox_binary import FirefoxBinary
#firefox_binary = FirefoxBinary(firefox_path="/usr/bin/firefox-esr")

#from selenium.webdriver.common.utils import keys_to_typing

#def wheel(locator, offset):
#    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
#    driver = s2l.driver
#   # driver.find_element_by_css_selector(locator).click()
#    elem = driver.find_element_by_class_name(locator)
#    ActionChains(driver).move_to_element(elem)
#    ag.moveTo(900, 500)
#    ag.scroll(int(offset))
# driver.find_element_by_css_selector(locator).wheel()

#def wheelm(locator, offset):
#    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
#    driver = s2l.driver
#   # driver.find_element_by_css_selector(locator).click()
#    elem = driver.find_element_by_class_name(locator)
#    ActionChains(driver).move_to_element(elem)
#    ag.moveTo(0, 0)
#    ag.scroll(int(offset))

def doubleclick_element_at_coordinates(locator, xoffset, yoffset):
    if not locator:
        raise ValueError()
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    #driver 
#    elem = driver.find_element_by_id(locator)
#    elem = driver.find_element_by_css_selector(locator)
#    elem = s2l._element_find(locator, True, True)
    elem = s2l.find_element(locator)
    ActionChains(driver).move_to_element(elem).move_by_offset(xoffset, yoffset).double_click().perform()

#def file():
#    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
#    driver = s2l.driver
#    driver.find_element_by_css_selector('[class~='fa-download']').click()
#    ActionChains(driver).sendkeys(elem, 'C:\\temp\\x.txt')

def  click_css(elem):
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    driver.find_element_by_css_selector(elem).click()

def  click_text(txt):
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    driver.find_element_by_link_text(txt).click()

def send_up_key():
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    ActionChains(driver).send_keys(Keys.UP).perform()

def send_down_key():
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    ActionChains(driver).send_keys(Keys.DOWN).perform()

def send_enter_key():
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    ActionChains(driver).send_keys(Keys.ENTER).perform()

#def drag_to(button, *coordinates):
#    coordinates = [int(coord) for coord in coordinates]
#    ag.dragTo(*coordinates, duration=1, button=button)

#def convert_to_EPSG3067(x,y):
#    OutProj = Proj(init='epsg:3067')
#    InProj = Proj(init='epsg:4326')
#    x2,y2 = transform(InProj,OutProj,x,y)
#    return     x2,y2

#def convert_to_WGS84(x,y):
#    InProj = Proj(init='epsg:3067')
#    OutProj = Proj(init='epsg:4326')
#    x2,y2 = transform(InProj,OutProj,x,y)
#    return     x2,y2

def drag_and_drop_by_offset(locator, xoffset, yoffset):
    if not locator:
        raise ValueError()
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    element = s2l.find_element(locator)
    ActionChains(driver).drag_and_drop_by_offset(element,int(xoffset), int(yoffset)).perform()

def press_shift_and_drag_and_drop_by_offset(locator, xoffset, yoffset):
    if not locator:
        raise ValueError()
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    element = s2l.find_element(locator)
    ActionChains(driver).key_down(Keys.SHIFT).drag_and_drop_by_offset(element,int(xoffset), int(yoffset)).key_up(Keys.SHIFT).perform()

def press_control_and_drag_and_drop_by_offset(locator, xoffset, yoffset):
    if not locator:
        raise ValueError()
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    element = s2l.find_element(locator)
    ActionChains(driver).key_down(Keys.CONTROL).drag_and_drop_by_offset(element,int(xoffset), int(yoffset)).key_up(Keys.CONTROL).perform()

def click_element_and_press_control_at_coordinates(locator, xoffset, yoffset):
    if not locator:
        raise ValueError()
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    elem = s2l.find_element(locator)
    ActionChains(driver).key_down(Keys.CONTROL).move_to_element(elem).move_by_offset(xoffset, yoffset).click().key_up(Keys.CONTROL).perform()

def hold_control_and_click_element_at_coordinates(locator, xoffset, yoffset):
    if not locator:
        raise ValueError()
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    elem = s2l.find_element(locator)
    ActionChains(driver).key_down(Keys.CONTROL).move_to_element(elem).move_by_offset(xoffset, yoffset).click().perform()

def hold_control_and_drag_by_offset(locator, xoffset, yoffset):
    if not locator:
        raise ValueError()
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    element = s2l.find_element(locator)
    ActionChains(driver).key_down(Keys.CONTROL).drag_and_drop_by_offset(element,int(xoffset), int(yoffset)).perform()

def release_control():
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    ActionChains(driver).key_up(Keys.CONTROL).perform()

def mouse_cl(locator):
    s2l = BuiltIn().get_library_instance('SeleniumLibrary')
    driver = s2l.driver
    elem = s2l.find_element(locator)
    #ActionChains(driver).wheelevent(elem).perform()
   # TouchActions(driver).scroll_from_element(elem, 100, 0).perform()
    ActionChains(driver).move_to_element(elem).send_keys(Keys.UP).perform()
    ActionChains(driver).move_to_element(elem).send_keys(Keys.UP).perform()
# ActionChains(driver).wheel(elem).perform()
#   ActionChains(driver).click(elem).perform()

def set_max_redirects():
    session = requests.Session()
    session.max_redirects = 100